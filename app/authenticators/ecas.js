import Ember from 'ember';
import Base from 'ember-simple-auth/authenticators/base';
import eraseCookie from '../utils/clear-cookie';

export default Base.extend({
  ajax: Ember.inject.service(),
  restore() {
    return this.get('ajax').request("sessions/current", {
      type: 'GET',
      dataType: 'json',
      headers: {
        'Content-Type': 'application/vnd.api+json'
      }
    });
  },

  /**
   * authenticate just checks if a session is present
   *
   * @param options
   * @returns {Promise}
     */
  authenticate() {
    return this.get('ajax').request("sessions/current", {
      type: 'GET',
      dataType: 'json',
      headers: {
        'Content-Type': 'application/vnd.api+json'
      }
    }).catch(function(){
        eraseCookie('ecas');
        eraseCookie('JSESSIONID');
        eraseCookie('proxy_session');
    });
  },

  invalidate() {
    var invalClient = function(){
      eraseCookie('ecas');
      eraseCookie('JSESSIONID');
      eraseCookie('proxy_session');
      Ember.run.later(function(){
        window.location.href = "https://ecas.ec.europa.eu/cas/logout";
      }, 2000);
    };

    return this.get('ajax').request('/sessions/current', {
      type: 'DELETE',
      headers: {
        'Content-Type': 'application/vnd.api+json'
      }
    }).then(invalClient).catch(invalClient);
  }
});
