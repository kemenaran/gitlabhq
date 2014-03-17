# encoding: utf-8

class AssetsUploader < CarrierWave::Uploader::Base
  storage :file

  def initialize(project)
    @project = project
  end

  def store_dir
    "uploads/#{@project.namespace.path}/#{@project.path}"
  end

  def filename
    @uuid ||= SecureRandom.uuid;
    "#{@uuid}.#{file.extension}" if original_filename.present?
  end

  def image?
    img_ext = %w(png jpg jpeg gif bmp tiff)
    if file.respond_to?(:extension)
      img_ext.include?(file.extension.downcase)
    else
      # Not all CarrierWave storages respond to :extension
      ext = file.path.split('.').last.downcase
      img_ext.include?(ext)
    end
  rescue
    false
  end

  #def secure_url
  #  Gitlab.config.gitlab.relative_url_root + "/files/#{model.class.to_s.underscore}/#{model.id}/#{file.filename}"
  #end

  def file_storage?
    self.class.storage == CarrierWave::Storage::File
  end
end
