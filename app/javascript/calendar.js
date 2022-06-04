$(document).on('turbolinks:load', function() {
  // 
  $("#mon_calendar td").on("click",function(e){
    

    var year_now =  $(".calendar-heading H3").text().trim().replace("年","-");
    var month_now = $(".calendar-title").text().trim().replace("月","-");
    var td_now = $(this).text().trim().slice(0,2)
    var s_day = (year_now+month_now+td_now).replace(/\r?\n/g,"");

    console.log(s_day)
    $.ajax({
      url: "calendars",
      type: "GET",
      data: {s_day: s_day},
      dataType: "json" 
    }).done(function(result) {
      //今呼び出しているパーシャルを消して、受け取ったパーシャルを表示
      // $('#footer').remove();
      $('#footer').html(result.html);
      console.log(result.html)
    }).fail(function(err){
        console.log(err);
    })
  })
})

