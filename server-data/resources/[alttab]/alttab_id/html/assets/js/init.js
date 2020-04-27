$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      var userData    = event.data.array['user'][0];
      var licenseData = event.data.array['licenses'];
      var sex         = userData.sex;

      if ( type == 'driver' || type == null) {
        $('img').show();
        if ( sex.toLowerCase() == 'm' ) {
          $('#sex').text('homme');
        } else {
          $('#sex').text('femme');
        }
        if (userData.job == "fisherman") {
          userData.job = "Pêcheur"
        } else if (userData.job == "lumberjack") {
          userData.job = "Bûcheron"
        } else if (userData.job == "mechanic") {
          userData.job = "Mécano"
        } else if (userData.job == "slaughterer") {
          userData.job = "Abatteur"
        } else if (userData.job == "fisherman") {
          userData.job = "Pêcheur"
        } else if (userData.job == "realestateagent") {
          userData.job = "Agent immo."
        } else if (userData.job == "cardealer") {
          userData.job = "Concess."
        } else if (userData.job == "gang_1") {
          userData.job = "Gamer"
        } else if (userData.job == "unemployed") {
          userData.job = "Chômeur"
        } else if (userData.job == "state") {
          userData.job = "État"
        }

        $('#fname').text(userData.firstname);
        $('#lname').text(userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#height').text(userData.height + " cm");
        $('#job').html("Trv.: &nbsp;<span style=\"font-weight:800;\">" + userData.job + "</span>");
        $('#cin').html("N° CIN: &nbsp;<span style=\"font-weight:800;\">" + event.data.cin + "</span>");

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
          Object.keys(licenseData).forEach(function(key) {
            var type = licenseData[key].type;

            if ( type == 'drive_bike') {
              type = 'bike';
            } else if ( type == 'drive_truck' ) {
              type = 'truck';
            } else if ( type == 'drive' ) {
              type = 'car';
            }

            if ( type == 'bike' || type == 'truck' || type == 'car' ) {
              $('#licenses').append('<p>'+ type +'</p>');
            }
          });
        }

          $('#id-card').css('background', 'url(assets/images/license.png)');
        } else {
          $('#id-card').css('background', 'url(assets/images/idcard.png)');
        }
      } else if ( type == 'weapon' ) {
        $('img').hide();
        $('#name').css('color', '#d9d9d9');
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);

        $('#id-card').css('background', 'url(assets/images/firearm.png)');
      }

      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#fname').text('');
      $('#lname').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#sex').text('');
      $('#job').text('');
      $('#cin').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});
