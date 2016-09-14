function PostsCtrl($scope) {
  $scope.posts = [
    {content: 'learn angular'},
    {content: 'learn ember'}
  ];

  $scope.addPost = function () {
    $scope.posts.push($scope.newPost)  
    $scope.newPost = {}
  }
}
;
