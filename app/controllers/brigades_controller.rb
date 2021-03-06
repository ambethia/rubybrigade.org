class BrigadesController < ApplicationController
  include GeoKit::Geocoders
  include BrigadesHelper

  before_filter :disallow_subdomain, :except => [:index, :search]
  before_filter :ensure_domain,      :only   => [:index, :search]
  before_filter :load_countries,     :only   => [:new,   :edit, :update, :create]
  
  # GET /brigades
  # GET /brigades.xml
  def index
    if request.subdomains.length > 0 && request.subdomains.first != 'www'
      params[:search] = request.subdomains.first
      search
    else
      @brigades = Brigade.find(:all)
    
      respond_to do |format|
        format.html { load_new_brigades_and_events }
        format.xml  { render :xml => @brigades }
        format.json { render :text => points_for_mapping(@brigades) }
      end
    end
  end

  # GET /brigades/1
  # GET /brigades/1.xml
  def show
    @brigade = Brigade.find(params[:id])
    @title   = @brigade.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @brigade }
    end
  end

  # GET /brigades/new
  # GET /brigades/new.xml
  def new
    @title = "New Brigade"
    @brigade = Brigade.new

    respond_to do |format|
      format.html { render :layout => "alternative" }
      format.xml  { render :xml => @brigade }
    end
  end

  # GET /brigades/1;edit
  def edit
    @title = "Edit Brigade"
    @brigade = Brigade.find(params[:id])
    render :layout => "alternative"
  end

  # POST /brigades
  # POST /brigades.xml
  def create
    @brigade = Brigade.new(params[:brigade])

    respond_to do |format|
      if verify_recaptcha(@brigade) && @brigade.save
        flash[:notice] = 'Brigade was successfully created.'
        format.html { redirect_to(@brigade) }
        format.xml  { render :xml => @brigade, :status => :created, :location => @brigade }
      else
        format.html { render :action => "new", :layout => "alternative" }
        format.xml  { render :xml => @brigade.errors }
      end
    end
  end

  # PUT /brigades/1
  # PUT /brigades/1.xml
  def update
    @brigade = Brigade.find(params[:id])

    respond_to do |format|
      if verify_recaptcha(@brigade) && @brigade.update_attributes(params[:brigade])
        flash[:notice] = 'Brigade was successfully updated.'
        format.html { redirect_to(@brigade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "alternative" }
        format.xml  { render :xml => @brigade.errors }
      end
    end
  end

  # DELETE /brigades/1
  # DELETE /brigades/1.xml
  def destroy
    @title   = "Delete Brigade"
    @brigade = Brigade.find(params[:id])
    if request.delete?
      if verify_recaptcha
        @brigade.destroy
        flash[:notice] = "Brigade was deleted"

        respond_to do |format|
          format.html { redirect_to(brigades_url) }
          format.xml  { head :ok }
        end
      else
        flash[:notice] = "Recaptcha was incorrect"
      end
    end
  end
  
  # yep, this method is hairy, but it works. could use some love though.
  def search
    # first search by subdomain slug field
    @brigade = Brigade.find_by_subdomain(params[:search])
    if @brigade
      @title = @brigade.name
      respond_to do |format|
        format.html do
          if subdomain_present?
            params[:search] = nil
            render :action => 'show'
          else
            redirect_to brigade_url(@brigade)
          end
        end
        format.xml  { render :xml => @brigade }
      end
    
    # if still unknown, geocode search string and search
    else
      @title = "Search Brigades"
      # remove all non word characters or underscores
      search_to_geocode = params[:search].gsub(/\W/, ' ').gsub(/_/, ' ')

      # attempt to geocode and search. 
      @location = GoogleGeocoder.geocode(search_to_geocode)
      @bounds   = GeoKit::Bounds.from_point_and_radius(@location, 300)
      if @location.success
        @brigades = Brigade.find :all, :bounds => @bounds, :limit => 5
        respond_to do |format|
          format.html do
            load_new_brigades_and_events
            render :action => 'index'
          end
          format.xml  { render :xml => @brigades }
        end
      else
    	  # if geocode fails, find none
  	    @brigades = []
  	    flash[:notice] = "No brigrades found."
  	    flash.discard

        respond_to do |format|
          format.html do 
            load_new_brigades_and_events
            render :template => 'brigades/index'
          end
          format.xml  { render :xml => @brigades }
        end
      end
    end
    
  end
  
  private
    def load_new_brigades_and_events
      @upcoming_events = Event.upcoming(2)
      @newest_brigades = Brigade.newest(3)
    end
    
    def load_countries
      data       = YAML.load File.open(RAILS_ROOT+"/lib/countries.yml")
      @countries = data.map(&it).map do |country|
        [country["printable_name"], country["iso"]]
      end
    end
    
end
