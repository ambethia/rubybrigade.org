CREATE TABLE `brigades` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `membership_size` int(11) default NULL,
  `website_url` varchar(255) default NULL,
  `rss_url` varchar(255) default NULL,
  `ical_url` varchar(255) default NULL,
  `established_on` date default NULL,
  `city` varchar(255) default NULL,
  `state_region` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `postal_code` varchar(255) default NULL,
  `lat` decimal(15,10) default NULL,
  `lng` decimal(15,10) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `subdomain` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `feed_items` (
  `id` int(11) NOT NULL auto_increment,
  `summary` varchar(255) default NULL,
  `description` text,
  `uri` varchar(255) default NULL,
  `location` text,
  `starts_at` datetime default NULL,
  `ends_at` datetime default NULL,
  `type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `feeds` (
  `id` int(11) NOT NULL auto_increment,
  `uri` varchar(255) default NULL,
  `last_checked_at` datetime default NULL,
  `brigade_id` int(11) default NULL,
  `type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `logged_exceptions` (
  `id` int(11) NOT NULL auto_increment,
  `exception_class` varchar(255) default NULL,
  `controller_name` varchar(255) default NULL,
  `action_name` varchar(255) default NULL,
  `message` text,
  `backtrace` text,
  `environment` text,
  `request` text,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO schema_info (version) VALUES (5)