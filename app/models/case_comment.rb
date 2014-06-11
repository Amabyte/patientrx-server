class CaseComment < ActiveRecord::Base
  validates_presence_of :case_id, :who
  validate :validate_case_comment
  belongs_to :case
  before_destroy :delete_files

  def image_url
    get_file_url get_aws_s3_bucket[image_with_folder]
  end

  def audio_url
    get_file_url get_aws_s3_bucket[audio_with_folder]
  end

  def as_json(options = {})
    result = super({except: [:image, :audio], :methods => [:image_url, :audio_url]}.merge(options))
    result.delete("docter_id") if docter_id.nil?
    result
  end

  private
    def delete_files
      get_aws_s3_bucket[image_with_folder].delete
      get_aws_s3_bucket[audio_with_folder].delete
    end

    def get_aws_s3_bucket
      AWS::S3.new.buckets[Settings.aws_s3.bucket_name].objects
    end

    def get_file_url object
      object.url_for(:get,{expires: Settings.link_expires.second.from_now, secure: true}).to_s
    end

    def image_with_folder
      "images/#{image}"
    end

    def audio_with_folder
      "audios/#{audio}"
    end

    def validate_case_comment
      if self.case.case_comments.count == 0 && message.blank?
        errors[:base] << 'Message should be present for first case comment'
      elsif message.blank? && image.blank? && audio.blank?
        errors[:base] << 'Message, image or audio should be present'
      end
    end
end
