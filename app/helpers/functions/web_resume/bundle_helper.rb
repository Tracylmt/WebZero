
require 'fileutils'

module Functions::WebResume::BundleHelper

    def self.bundle_to_local(template_path, resume_str, resume_relative_path, dest_path)

        # Create the directory if it does not exist
        dest_dir = File.dirname(dest_path)
        unless File.directory?(dest_dir)
            FileUtils.mkdir_p(dest_dir)
        end

        FileUtils.cp_r template_path + '/.', dest_path

        File.open(dest_path + '/' + resume_relative_path + '/resume.js', 'w') { |file| 
            file.write(resume_str)
        }

        return dest_path
    end

end
