@LoginCtrl = ["$scope", "User", "Restangular", "$rootScope", "$location", "$routeParams", "$window", ($scope, User, Restangular, $rootScope, $location, $routeParams, $window) ->
  console.log("::::????>>>>>>>")
  #index
  $scope.destroyUser = (item) ->
    item.remove().then ->
      $scope.announcements.splice $scope.announcements.indexOf(item), 1

  #show
  $scope.getUser = (id) ->
    if $routeParams.tab
      $scope.selectTab($routeParams.tab)
      User.one(id).customGET($routeParams.tab).then (res) ->
        $scope.announcement = res
    else
      if id
        $scope.tab = null
        User.one(id).get().then (res) ->
          $scope.announcement = res
      else
        $scope.attachment_ids = []
        $scope.announcement =
          attachment_ids: $scope.attachment_ids

    return

  $scope.announcementInit = ->
    $scope.getUser($routeParams.id)

  #form
  $scope.submitUser = (data) ->
    if data.id
      data.put().then (res) ->
        unless res.meta.errors
          $location.path("/announcements/" + res.id)
        else
         $scope.data_errors = res.meta.errors
    else
      User.post(data).then (res) ->
        unless res.meta.errors
          $location.path("/announcements/" + res.id)
        else
         $scope.data_errors = res.meta.errors

    return

  $scope.announcementFormInit = ->
    $scope.getUserCategories()
    $scope.getUser($routeParams.id)
]