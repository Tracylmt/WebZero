
/**
 * Template-specific adapter
 * @param {*} resume 
 */

function htmlEncode(value){
    return $('<div/>').text(value).html();
}
  
function htmlDecode(value){
    return $('<div/>').html(value).text();
}

function resume_adapter(resume) {
    var result = {};
    result["website-title"] = radpt.name(resume);
    result["header-title"] = radpt.name(resume);
    result["name"] = radpt.name(resume);
    result["title"] = "Hi, my name is " + radpt.name(resume);
    result["subtitle"] = radpt.skills(resume);
    result["email"] = radpt.email(resume);

    result["occupation"] = radpt.current(resume);

    radpt.for_each_school(resume, 
        function(isCurrent, start, end, org, degree, gpa, summary) {
            // assume only one school
            if (!isCurrent) {
                result["html-personal-intro"] = "I graduate from " + org + 
                " with a GPA of " + gpa + "<br>" + 
                degree + "    " + start + " - " + end;
            } else {
                result["html-personal-intro"] = "I am a student in " + org + 
                " with a current GPA of " + gpa + "<br>" + 
                degree + "    " + start + " - " + end;
            }
        });
    result["occupation"] = radpt.current(resume);

    result["phone"] = radpt.phone(resume);
    result["html-skills"] = "";

    jQuery.each(radpt.skills(resume), function(key, val) {
        result["html-skills"] += 
        String.raw `<span>` + val + String.raw `, </span>`;
    })

    result["project-subtitle"] = "Here are my projects";
    result["html-projects"] = "";


    radpt.for_each_position(resume, function(isCurrent, start, end, org, title, summary) {
        str = String.raw `
        <div class="col-md-4">
          <div class="work-box">
            <a href="https://www.google.com">
              <!-- {{This is where you put your link to your project}} -->
              <div class="work-img">
                <img src="https://images.squarespace-cdn.com/content/v1/5a5906400abd0406785519dd/1547305849352-CYT6FWXR75U7ZUBL5NAK/ke17ZwdGBToddI8pDm48kKAwwdAfKsTlKsCcElEApLR7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UegTYNQkRo-Jk4EWsyBNhwKrKLo5CceA1-Tdpfgyxoog5ck0MD3_q0rY3jFJjjoLbQ/IB+alex.jpg?format=2500w" alt="" class="img-fluid">
                <!-- {{This is where you put your project image}} -->
    
              </div>
              <div class="work-content">
                <div class="row">
                  <div class="col-sm-8">
                    <h2 class="w-title">@#@#{TITLE}#@#@</h2>
                    <!-- {{This is your projects title}} -->
                    <div class="w-more">
                      <span class="w-date">@#@#{DESCRIPTION}#@#@</span>
                      <!-- {{This is your description of you projects}} -->
                    </div>
                  </div>
                  <div class="col-sm-4">
                    <div class="w-like">
                      <span class="ion-ios-plus-outline"></span>
                    </div>
                  </div>
                </div>
              </div>
            </a>
          </div>
        </div>`.replaceAll("@#@#{DESCRIPTION}#@#@", htmlEncode(summary)).replaceAll("@#@#{TITLE}#@#@", htmlEncode(title));
        if (str === undefined) {
            console.log("undefined in for_each_position");
        } else {
            result["html-projects"] += str;
        }
    });
    console.log(result);
    return result;
}

function load_page_from_json(metadata) {
    jQuery.each(metadata, function(key, val) {
        if (key == "website-title") {
            document.title = val;
        } else if (key.substring(0, 5) == 'html-') {
            $('#resume-' + key).html(val);
        } else {
            $('#resume-' + key).text(val);
        }
    })
}

$(window).load(function() {
    resume = user_resume();
    data = resume_adapter(resume);
    load_page_from_json(data);
    
    // This is about the animation in the original template
    loadSlide();
});

