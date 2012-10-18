# redmine_recaptcha

srstclair@gmail.com

Simple Redmine/ChiliProject plugin to add a reCAPTCHA to user self registration.

Relies on ambethia's recaptcha for rails plugin (http://github.com/ambethia/recaptcha/)

To install:

* make sure you have git installed!

* cd to your Redmine/ChiliProject directory

* install the plugin (use sudo if needed)

    * Redmine users

            ruby script/plugin install git://github.com/ambethia/recaptcha.git
            ruby script/plugin install git://github.com/srstclair/redmine_recaptcha.git 

    * Chiliproject users

            ruby script/plugin install git://github.com/srstclair/redmine_recaptcha.git 
            bundle install

* restart Redmine/ChiliProject

* sign in as an administrator

* go to Administration/Plugins/reCAPTCHA/Configure

* sign up for a recaptcha key at http://www.google.com/recaptcha (if you haven't already)

* enter your public and private recaptcha keys

* go to self registration page to see captcha!
