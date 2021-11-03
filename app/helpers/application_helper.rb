require_relative "functions/web_resume/bundle_helper.rb"
require_relative "functions/web_resume/resume_helper.rb"


module ApplicationHelper
  def generate(path)
    # path = "./OmkarResume.pdf"
    # if current_user
    #   puts "#{current_user.resume}"
    # end
    puts path
    if path == nil
      return
    end
    resume_str = Functions::WebResume::ResumeHelper::get_resume_js(path)
    template_path = 'app/helpers/functions/web_resume/template_0'
    resume_relative_path = 'js'
    dest_path = 'app/helpers/functions/web_resume/output_local'
    result = Functions::WebResume::BundleHelper::bundle_to_local(template_path, resume_str, resume_relative_path, dest_path)
  end
end
