module Resolvers
  module Attachments
    module Create
      class << self

        require 'aws-sdk-s3'


        def call(_, input, context)
          obj_hash = convert_data_uri_to_upload(image_url: input[:file])

          path = obj_hash[:image].tempfile.path

          s3 = Aws::S3::Resource.new(
            access_key_id: 'AKIAIYZDDECTXTMSGEDA',
            secret_access_key: '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',
            region:'us-east-2'
          )
          file_name = SecureRandom.hex(8)
          obj = s3.bucket('tutorbox-files')
          obj.load
          obj.object(file_name).upload_file(path)

          new_attachment = Attachment.new(
            name: file_name,
            url: "https://tutorbox-files.s3-us-east-2.amazonaws.com/#{file_name}",
            source_id: input[:sourceId],
            source_type: Video,
            created_by: context[:current_user]
          )

          context[:current_user].authorize!(:create, new_attachment)
          new_attachment.save!

          { attachment: new_attachment }
        end

        def split_base64(uri_str)
              if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
                uri = Hash.new
                uri[:type] = $1 # "image/gif"
                uri[:encoder] = $2 # "base64"
                uri[:data] = $3 # data string
                uri[:extension] = $1.split('/')[1] # "gif"
                return uri
              else
                return nil
              end
        end

        def convert_data_uri_to_upload(obj_hash)
              if obj_hash[:image_url].try(:match, %r{^data:(.*?);(.*?),(.*)$})
                image_data = split_base64(obj_hash[:image_url])
                image_data_string = image_data[:data]
                image_data_binary = Base64.decode64(image_data_string)

                temp_img_file = Tempfile.new("")
                temp_img_file.binmode
                temp_img_file << image_data_binary
                temp_img_file.rewind

                img_params = {:filename => "image.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}

                uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)


                obj_hash[:image] = uploaded_file
                obj_hash.delete(:image_url)
              end
          return obj_hash
        end
      end
    end
  end
end
