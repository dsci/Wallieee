(function() {

  /*
  Models
  */

  var WallPost, WallPostView, WallPosts;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  WallPost = (function() {

    __extends(WallPost, Backbone.Model);

    function WallPost() {
      WallPost.__super__.constructor.apply(this, arguments);
    }

    return WallPost;

  })();

  /*
  Views
  */

  WallPostView = (function() {

    __extends(WallPostView, Backbone.View);

    function WallPostView() {
      this.render = __bind(this.render, this);
      WallPostView.__super__.constructor.apply(this, arguments);
    }

    WallPostView.prototype.template = $('#postList');

    WallPostView.prototype.initialize = function() {
      this.model.bind('change', this.render);
      return this.render();
    };

    WallPostView.prototype.render = function() {
      this.addPost(this.model);
      return this;
    };

    WallPostView.prototype.addPost = function(model) {
      return $('#postList').append("<li>" + model.get('text') + "</li>");
    };

    return WallPostView;

  })();

  /*
  Collections
  */

  WallPosts = (function() {

    __extends(WallPosts, Backbone.Collection);

    function WallPosts() {
      WallPosts.__super__.constructor.apply(this, arguments);
    }

    WallPosts.prototype.model = WallPost;

    WallPosts.prototype.url = '/posts';

    return WallPosts;

  })();

  window.WallPost = WallPost;

  window.WallPostView = WallPostView;

  window.WallPosts = new WallPosts();

  jQuery(function() {
    var AppView;
    AppView = (function() {

      __extends(AppView, Backbone.View);

      function AppView() {
        this.submitPost = __bind(this.submitPost, this);
        this.render = __bind(this.render, this);
        AppView.__super__.constructor.apply(this, arguments);
      }

      AppView.prototype.el = '.posts';

      AppView.prototype.events = {
        "submit messageForm": "submitPost",
        "click .input": "submitPost"
      };

      AppView.prototype.initialize = function() {
        console.log($('#messageForm'));
        this.collection = window.WallPosts;
        this.collection.bind('all', this.render);
        this.collection.fetch();
        return this.render();
      };

      AppView.prototype.render = function() {
        var post, _i, _j, _len, _len2, _ref, _ref2, _results;
        console.log("I did something!");
        console.log($(this.el));
        _ref = this.collection.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          post = _ref[_i];
          console.log(post.get('text'));
        }
        _ref2 = this.collection.models;
        _results = [];
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          post = _ref2[_j];
          _results.push(new WallPostView({
            model: post
          }));
        }
        return _results;
      };

      AppView.prototype.submitPost = function(data) {
        console.log("submitted somethin");
        return false;
      };

      return AppView;

    })();
    window.App = AppView;
    return new App();
  });

}).call(this);
