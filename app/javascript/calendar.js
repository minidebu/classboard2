$(function(){
  // 
  $("#mon_calendar td").on("click",function(){
    var td_now = $(this).text().length;
    console.log(td_now);
  })
})

