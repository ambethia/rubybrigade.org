class BrigadesController < ApplicationController
  before_filter :disallow_subdomain, :except => [:index, :search]
  
  # GET /brigades
  # GET /brigades.xml
  def index
    if request.subdomains.length > 0 && request.subdomains.first != 'www'
      params[:search] = request.subdomains.first
      search
    else
      @brigades = Brigade.find(:all)
    
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @brigades }
      end
    end
  end

  # GET /brigades/1
  # GET /brigades/1.xml
  def show
    @brigade = Brigade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @brigade }
    end
  end

  # GET /brigades/new
  # GET /brigades/new.xml
  def new
    @brigade = Brigade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @brigade }
    end
  end

  # GET /brigades/1;edit
  def edit
    @brigade = Brigade.find(params[:id])
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
        format.html { render :action => "new" }
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
        format.html { render :action => "edit" }
        format.xml  { render :xml => @brigade.errors }
      end
    end
  end

  # DELETE /brigades/1
  # DELETE /brigades/1.xml
  def destroy
    @brigade = Brigade.find(params[:id])
    @brigade.destroy

    respond_to do |format|
      format.html { redirect_to(brigades_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    # first search by subdomain slug field
    @brigade = Brigade.find_by_subdomain(params[:search])
    if @brigade
      respond_to do |format|
        format.html { redirect_to(@brigade) }
        format.xml  { render :xml => @brigade }
      end
    
    # if still unknown, geocode search string and search
    else
      @brigades = Brigade.find :all, 
                               :origin => params[:search], 
  	                           :within => 10
  	
    	# if only one result, redirect to it
    	if @brigades.length == 1
        respond_to do |format|
          format.html { redirect_to(@brigades[0]) }
          format.xml  { render :xml => @brigades[0] }
        end
  	  else
        respond_to do |format|
          format.html { render :template => 'brigades/index'}
          format.xml  { render :xml => @brigades }
        end
      end
    end
    
  end
  
end
