module Attachments
	extend ActiveSupport::Concern

	included do
		attr_accessor :delete_icon
	  attr_reader :icon_remote_url  
	  before_validation { icon.clear if delete_icon == '1' }
	  has_attached_file :icon, styles: { thumb: '50x50>', original: '450x450>' }                   
	  validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be less than 2 megabytes' }
	  validates_attachment_content_type :icon,
	                                    :content_type => /^image\/(png|gif|jpeg)/,
	                                    :message => 'only (png/gif/jpeg) images'
	  process_in_background :icon
	  
	  attr_accessor :delete_pdf
	  attr_reader :pdf_remote_url
	  before_validation { pdf.clear if delete_pdf == '1' }
	  has_attached_file :pdf                
	  validates_attachment :pdf, :size => { :in => 0..5.megabytes, message: 'File must be less than 3 megabytes' }
	  validates_attachment_content_type :pdf,
	                                    :content_type => 'application/pdf',
	                                    :message => 'only PDF files allowed'
	end

	def icon_remote_url=(url_value)
     if url_value.present?
      self.icon = URI.parse(url_value)
      @icon_remote_url = url_value
    end
  end

  def pdf_remote_url=(url_value)
     if url_value.present?
      self.pdf = URI.parse(url_value)
      @pdf_remote_url = url_value
    end
  end

end