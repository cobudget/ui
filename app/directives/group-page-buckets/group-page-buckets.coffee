null

### @ngInject ###
global.cobudgetApp.directive 'groupPageBuckets', () ->
    restrict: 'E'
    template: require('./group-page-buckets.html')
    replace: true
    controller: ($scope, $location, Dialog) ->

      $scope.showBucket = (bucketId) ->
        $location.path("/buckets/#{bucketId}")

      $scope.showCompletedBuckets = ->
        $scope.completedBucketsShown = true

      $scope.hideCompletedBuckets = ->
        $scope.completedBucketsShown = false

      $scope.showCancelledBuckets = ->
        $scope.cancelledBucketsShown = true

      $scope.hideCancelledBuckets = ->
        $scope.cancelledBucketsShown = false

      $scope.confirmSaving = (membership) ->
        params =
          membership:
            saved_funds_at: moment()
        membership.remote.update(membership.id, params)

      $scope.indicateSaving = (membership) ->
        Dialog.confirm({
          content: "Thanks! This will help group admins know that the funds have not been abandoned."
        }).then ->
          $scope.confirmSaving(membership)

      return
