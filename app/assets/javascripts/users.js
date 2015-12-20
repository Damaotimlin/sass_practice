var main = function(){
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content')); // Retrieve Stripe public key for permission to interact with Stripe 
    // Watch for a form submission :
    $('#pro-form-submit-btn').click(function(event) {
        event.preventDefault(); // prevent the button defult functiob which is to block the immediately pass the form to Rails controller 
        $('input[type=submit]').prop('disabled', true); // Disable submit button to avoid double click
        var error = false,
            ccNum = $('#card_number').val(), // Grab values from forms and store each in variables
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        
        if (!error) {
            // Get the Stripe token:
            Stripe.card.createToken({ // if no error, send card information to Stripe; p.s. API update Stripe.createToken->Stripe.card.createToken
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler); // Stripe will return status and respomse(token)
        }
        return false;
    }); // Form submission
    
    function stripeResponseHandler(status, response) {
    // Get a reference to the form:
    var $form = $('#new_user'); //#new_user form was auto-defint by devise
    
    if (response.error) {
         // Show the errors on the form
        $form.find('#stripe-alert-text').text(response.error.message);
        $form.find('#stripe-alert-div').addClass('alert-danger');
        $form.find('input[type=submit]').prop('disabled', false);
        
        } else {
        // Get the token to the form:
        var token = response.id;
        // Add the token to the form
        // $form.append('<input type="hidden" name="user[stripe_card_token]" value="' + token +'" />'); // Added an other hidden field with Stripe token
        $form.append($('<input type="hidden" name="user[stripe_card_token]"/>').val(token))
        // Submit the form:
        $form.get(0).submit(); // After all, grap the first(0) form data,(in this case we only have 1 form declare in pro_form.html), 
                               // submit all data(all hidden) with Stripe token and send to our Rails server
        }
    };
};

$(document).ready(main);