//JAVASCRIPT CODE GOES HERE
//
$(document).ready(function(){
  $('#join_meetup').on('click'), (event) => {
    event.preventDefault();

    $.ajax({
      method: 'POST',
      url: '/meetups/params[:id]'
    }).done((data) => {
      alert(data);
    });



  }




}

// okay so basically on click I want to add whoever is logged in to the current meetup displayed
// So they click and their user.id = the user.id of a new meetup record that gets made
// And the currently selected meetup.id = the meetup.id of the new meetup_record
// this will make my show page work
