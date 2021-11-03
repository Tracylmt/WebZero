function date_tf(date) {
    if (date) {
        return date["year"] + "/" + date["month"];
    } else {
        return "";
    }
}

var radpt = {
    name: function(resume) {
        return resume["names"][0];
    },
    email: function(resume) {
        return resume["emails"][0]["value"];
    },
    phone: function(resume) {
        return resume["phones"][0]["value"];
    },
    for_each_school: function(resume, func) {
        jQuery.each(resume["schools"], function(key, val) {
            return func(val["isCurrent"], 
                date_tf(val["start"]),
                date_tf(val["end"]),
                val["org"] || "",
                val["degree"] || "",
                val["gpa"] || "",
                val["summary"] || "");
        });
    },
    for_each_position: function(resume, func) {
        jQuery.each(resume["positions"], function(key, val) {
            return func(val["isCurrent"], 
                date_tf(val["start"]),
                date_tf(val["end"]),
                val["org"] || "",
                val["title"] || "",
                val["summary"] || "");
        });
    },
    current: function(resume) {
        result = "";
        jQuery.each(resume["schools"], function(key, val) {
            if (val["isCurrent"] === true) {
                result = val["degree"];
                return false;
            }
            return true;
        });
        if (result != "") {
            return result;
        }
        
        jQuery.each(resume["positions"], function(key, val) {
            if (val["isCurrent"] === true) {
                result = val["title"] + " in " + val["org"];
                return false;
            }
            return true;
        });

        return result;
    },
    skills: function(resume) {
        return resume["summary"]["skills"].split(",");
    }
};
