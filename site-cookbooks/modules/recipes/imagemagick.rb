#
# Cookbook Name:: modules
# Recipe:: imagemagick
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%W(ImageMagick ImageMagick-devel).each do |pkg|
  package pkg do
    action :install
  end
end
