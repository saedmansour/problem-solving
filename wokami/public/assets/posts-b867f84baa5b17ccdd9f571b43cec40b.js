app = angular.module('wokami', ['ngResource']);

app.controller('InterestsCtrl', function ($scope, $resource) {
  
  Interest = $resource("/interests/:id", {id: "@id"}, {update: "put"});
  
  $scope.interests = Interest.query()

  $scope.addInterest = function () {
    interest = Interest.save($scope.newInterest);
    $scope.interests.push(interest)  
    $scope.newInterest = {}
  }
});
