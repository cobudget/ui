module.exports = 
  url: '/admin'
  template: require('./admin-page.html')
  controller: ($scope, $auth, $location, Records, $rootScope, config) ->

    $scope.currencies = [
      { code: 'USD', symbol: '$' },
      { code: 'NZD', symbol: '$' },
      { code: 'EUR', symbol: '€' }
    ]

    $scope.fetchAllGroups = ->
      Records.groups.getAll().then (groups) ->
        $scope.groups = groups

    $scope.fetchAllGroups()
    $scope.group = Records.groups.build()

    $scope.createGroup = ->
      if $scope.groupForm.$valid
        $scope.group.save().then (data) ->
          $scope.fetchAllGroups()

    $scope.uploadPathForGroup = (groupId) ->
      "#{config.apiPrefix}/allocations/upload?group_id=#{groupId}"

    $scope.onCsvUploadSuccess = (groupId) ->
      Records.groups.findOrFetchById(groupId).then (updatedGroup) ->
        updatedGroupIndex = _.findIndex $scope.groups, (group) ->
          group.id == groupId
        $scope.groups[updatedGroupIndex] = updatedGroup

    $scope.onCsvUploadCompletion = ->
      alert('upload complete')

    $scope.updateGroupCurrency = (groupId, currencyCode) ->
      Records.groups.findOrFetchById(groupId).then (group) ->
        group.currencyCode = currencyCode
        group.save().then ->
          $scope.fetchAllGroups()

    $scope.viewGroup = (groupId) ->
      $location.path("/groups/#{groupId}")

    return