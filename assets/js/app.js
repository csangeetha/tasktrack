// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";
let task_id=0;
let start_time_new="";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
function update_buttons() {
  $('.manage-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let manage = $(bb).data('manage');
    if (manage != "") {
      $(bb).text("Release");
    }
    else {
      $(bb).text("Manage");
    }
  });
}

function set_button(user_id, value) {
  $('.manage-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('manage', value);
    }
  });
  update_buttons();
}

function manage(user_id) {
  let text = JSON.stringify({
    manage: {
      manager_id: current_user_id,
      managee_id: user_id
    },
  });

  $.ajax(manage_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); },
  });
}

function release(user_id, manage_id) {
  $.ajax(manage_path + "/" + manage_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(user_id, ""); },
  });
}

function manage_click(ev) {
  let btn = $(ev.target);
  let manage_id = btn.data('manage');
  let user_id = btn.data('user-id');

  if (manage_id != "") {
    release(user_id, manage_id);
  }
  else {
    manage(user_id);
  }
}
function show_tb(ev){
  console.log("hi there btn!");
  console.log(ev.target.value);
  var id=ev.target.value;
  $('#start_time_id_'+id).val("");
  $('#end_time_id_'+id).val("");
  $('#tb_create_id-'+id).show();
  $('#start_tb_'+id).hide();

}

function create_time_block(ev){
  var id=ev.target.value;
  var start_time_val=$('#start_time_id_'+id).val();
  var end_time_val=$('#end_time_id_'+id).val();


  let text = JSON.stringify({
    time__block: {
      start_time: start_time_val+":00.000000Z",
      end_time: end_time_val+":00.000000Z",
      for_task_id: id
    },
  });
  console.log(text)

  $.ajax(time__block_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      $('#tb_create_id-'+id).hide();
      $('#start_tb_'+id).show();
      location.reload();
    },
    error: () => {
      alert("Please enter correct values")
    }
  });
}

function delete_tb(ev){
  var id=ev.target.value;
  var time_block_id = $(ev.target).data('time-block');
  console.log(id , time_block_id);

  $.ajax(time__block_path + "/" + time_block_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => {location.reload();
    },
    error: () => {
      alert("Can't delete task")
    }
  });
  //$('#time-block-div-'+id).load('http://localhost:4000/feed' + ' #time-block-div-'+id);
}

function edit_time_block(ev) {
  var id=ev.target.value;
  var tbid = $(ev.target).data('time-id');
  $('#tb_start_time_'+id+'_'+tbid).hide();
  $('#tb_end_time_'+id+'_'+tbid).hide();
  $('#new_start_time_id_'+id+'_'+tbid).show();
  $('#new_end_time_id_'+id+'_'+tbid).show();
  $('#update_button_'+id+'_'+tbid).show();
  $('#edit_button_'+id+'_'+tbid).hide();
  $('#close_btn_'+id+'_'+tbid).show();
  $('#delete_btn_'+id+'_'+tbid).hide();
  console.log(id+'_'+tbid);
}
function update_time_block(ev){
  var id=ev.target.value;
  var tbid = $(ev.target).data('time-id');
  var start_time_val=$('#new_start_time_id_'+id+'_'+tbid).val();
  var end_time_val=$('#new_end_time_id_'+id+'_'+tbid).val();
  start_time_val+=":00.000000Z";
  end_time_val+=":00.000000Z";
  if(start_time_val == null || start_time_val==":00.000000Z") start_time_val=$('#tb_start_time_'+id+'_'+tbid).html();
  if(end_time_val == null || end_time_val==":00.000000Z") end_time_val=$('#tb_end_time_'+id+'_'+tbid).html();

  let text = JSON.stringify({
    time__block: {
      start_time: start_time_val,
      end_time: end_time_val,
      for_task_id: id
    },
  });
  console.log(text);

  $.ajax(time__block_path+ "/" + tbid, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      $('#tb_start_time_'+id+'_'+tbid).show();
      $('#tb_end_time_'+id+'_'+tbid).show();
      $('#new_start_time_id_'+id+'_'+tbid).hide();
      $('#new_end_time_id_'+id+'_'+tbid).hide();
      $('#update_button_'+id+'_'+tbid).hide();
      $('#edit_button_'+id+'_'+tbid).show();
      $('#new_start_time_id_'+id+'_'+tbid).val("");
      $('#new_end_time_id_'+id+'_'+tbid).val("");
      $('#close_btn_'+id+'_'+tbid).hide();
      $('#delete_btn_'+id+'_'+tbid).show();
      location.reload();
    },
    error: () => {
      alert("Please enter correct values")
    }
  });
}
function close_edit_tb(ev){
  var id=ev.target.value;
  var tbid = $(ev.target).data('time-block');
  $('#tb_start_time_'+id+'_'+tbid).show();
  $('#tb_end_time_'+id+'_'+tbid).show();
  $('#new_start_time_id_'+id+'_'+tbid).hide();
  $('#new_end_time_id_'+id+'_'+tbid).hide();
  $('#update_button_'+id+'_'+tbid).hide();
  $('#edit_button_'+id+'_'+tbid).show();
  $('#new_start_time_id_'+id+'_'+tbid).val("");
  $('#new_end_time_id_'+id+'_'+tbid).val("");
  $('#close_btn_'+id+'_'+tbid).hide();
  $('#delete_btn_'+id+'_'+tbid).show();
}

function close_tb(ev){
  $('#tb_create_id-'+ev.target.value).hide();
  $('#start_tb_'+id).show();
}
function start_time_block(ev){
  let id=ev.target.value;
  task_id = id;
  start_time_new = new Date($.now());

  $('#start_tb_'+id).hide();
  $('#stop_tb_'+id).show();
  $('#create_btn_'+id).hide();
}

function stop_time_block(ev) {
  let end_time_new =new Date($.now());

  let text = JSON.stringify({
    time__block: {
      start_time: start_time_new,
      end_time: end_time_new,
      for_task_id: task_id
    },
  });
  console.log(text);
  $.ajax(time__block_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      $('#start_tb_'+task_id).show();
      $('#stop_tb_'+task_id).hide();
      $('#create_btn_'+task_id).show();
      location.reload();
    },
    error: () => {
      alert("Please enter correct values")
    }
  });
}

function init_manage() {
  if (!$('.manage-button')) {
    return;
  }
  console.log("hi there!");
  $(".manage-button").click(manage_click);

  update_buttons();
  console.log("hi there !");
  hide_everything();
  $('.create-tb-button').click(show_tb);
  $('.submit-tb').click(create_time_block);
  $('.delete-btn').click(delete_tb);
  $('.edit-button').click(edit_time_block);
  $('.update-button').click(update_time_block);
  $('.close-btn').click(close_edit_tb);
  $('.close-tb').click(close_tb);
  $('.start-tb-button').click(start_time_block);
  $('.stop-tb-button').click(stop_time_block);

}
function hide_everything(){
  $('.close-btn').hide();
  $("div[id^='tb_create_id-']" ).hide();
  $("input[id^='new_start_time_id_']" ).hide();
  $("input[id^='new_end_time_id_']" ).hide();
  $("button[id^='update_button']").hide();
  $("button[id^='stop_tb_']").hide();
}
$(init_manage);
