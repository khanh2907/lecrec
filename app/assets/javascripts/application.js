// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

function endsWith(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
}

function calculateSince(datetime)
{
    var tTime=new Date(datetime);
    var cTime=new Date();
    var sinceMin=Math.round((cTime-tTime)/60000);
    if(sinceMin==0)
    {
        var sinceSec=Math.round((cTime-tTime)/1000);
        if(sinceSec < 10)
            var since='less than 10 seconds ago';
        else if(sinceSec < 20)
            var since='less than 20 seconds ago';
        else
            var since='half a minute ago';
    }
    else if(sinceMin==1)
    {
        var sinceSec=Math.round((cTime-tTime)/1000);
        if(sinceSec==30)
            var since='half a minute ago';
        else if(sinceSec < 60)
            var since='less than a minute ago';
        else
            var since='1 minute ago';
    }
    else if(sinceMin < 45)
        var since=sinceMin+' minutes ago';
    else if(sinceMin > 44 && sinceMin < 60)
        var since='about 1 hour ago';
    else if(sinceMin < 1440){
        var sinceHr=Math.round(sinceMin/60);
        if(sinceHr==1)
            var since='about 1 hour ago';
        else
            var since='about '+sinceHr+' hours ago';
    }
    else if(sinceMin > 1439 && sinceMin < 2880)
        var since='1 day ago';
    else
    {
        var sinceDay=Math.round(sinceMin/1440);
        var since=sinceDay+' days ago';
    }
    return since;
}

function encodeHTML(s) {
    return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/"/g, '&quot;');
}