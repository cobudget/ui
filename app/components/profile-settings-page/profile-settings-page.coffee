module.exports =
  resolve:
    userValidated: ($auth) ->
      $auth.validateUser()
    membershipsLoaded: ->
      global.cobudgetApp.membershipsLoaded
  url: '/profile_settings?previous_group_id'
  template: require('./profile-settings-page.html')
  controller: (CurrentUser, $location, $scope, $stateParams) ->

    $scope.currentUser = CurrentUser()
    previousGroupId = $stateParams.previous_group_id || CurrentUser().primaryGroup().id

    $scope.back = ->
      $location.search('previous_group_id', null)
      $location.path("/groups/#{previousGroupId}")
