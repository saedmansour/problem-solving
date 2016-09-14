var wokamiApp = angular.module('wokamiApp', []);
 
wokamiApp.controller('subjectListCtrl', function ($scope) {
  $scope.subjects = [
    {'name': 'Nexus S',
     'description': 'Fast just got faster with Nexus S.'},
    {'name': 'Motorola XOOM™ with Wi-Fi',
     'description': 'The Next, Next Generation tablet.'},
    {'name': 'MOTOROLA XOOM™',
     'description': 'The Next, Next Generation tablet.'}
  ];
});
