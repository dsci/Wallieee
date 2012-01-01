(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  jQuery(function() {
    /*
    	Models
    */
    var AppView, WallPost, WallPostView, WallPosts;
    WallPost = (function() {

      __extends(WallPost, Backbone.Model);

      function WallPost() {
        WallPost.__super__.constructor.apply(this, arguments);
      }

      return WallPost;

    })();
    window.WallPost = WallPost;
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
    window.WallPosts = new WallPosts();
    /*
    	Views
    */
    WallPostView = (function() {

      __extends(WallPostView, Backbone.View);

      function WallPostView() {
        this.setText = __bind(this.setText, this);
        this.render = __bind(this.render, this);
        WallPostView.__super__.constructor.apply(this, arguments);
      }

      WallPostView.prototype.template = _.template($('#postList').html());

      WallPostView.prototype.tagName = "li";

      WallPostView.prototype.className = "messageRow";

      WallPostView.prototype.initialize = function() {
        this.model.bind('change', this.render);
        return this.render();
      };

      WallPostView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        this.setText();
        return this;
      };

      WallPostView.prototype.setText = function() {
        var text;
        text = this.model.get('text');
        return this.$('.walltext').text(text);
      };

      return WallPostView;

    })();
    window.WallPostView = WallPostView;
    AppView = (function() {

      __extends(AppView, Backbone.View);

      function AppView() {
        this.addOne = __bind(this.addOne, this);
        this.submitPost = __bind(this.submitPost, this);
        this.render = __bind(this.render, this);
        AppView.__super__.constructor.apply(this, arguments);
      }

      AppView.prototype.el = '.container';

      AppView.prototype.countTemplate = _.template($('#wallpostCount').html());

      AppView.prototype.events = {
        "submit #messageForm": "submitPost"
      };

      AppView.prototype.initialize = function() {
        this.collection = window.WallPosts;
        this.collection.bind('all', this.render, this);
        this.collection.bind('add', this.addOne, this);
        this.collection.fetch();
        return this.render();
      };

      AppView.prototype.render = function() {
        var post, variables, view, _i, _len, _ref, _results;
        $('#message').focus();
        variables = {
          total: this.collection.length
        };
        $('#count').html(this.countTemplate(variables));
        $("#recents #recents-list").children().remove();
        _ref = this.collection.models;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          post = _ref[_i];
          view = new WallPostView({
            model: post
          });
          _results.push($("#recents #recents-list").prepend(view.render().el));
        }
        return _results;
      };

      AppView.prototype.submitPost = function() {
        var post;
        if ($('#message').val() === "") {
          $('#errorAlert').show();
        } else {
          $('#errorAlert').hide();
          post = this.collection.create({
            text: $('#message').val()
          });
          this.resetInput();
        }
        return false;
      };

      AppView.prototype.resetInput = function() {
        $('#message').val("");
        return $('#message').focus();
      };

      AppView.prototype.addOne = function(post) {
        var view;
        view = new WallPostView({
          model: post
        });
        return $("#recents #recents-list").prepend(view.render().el);
      };

      return AppView;

    })();
    window.App = AppView;
    return new App();
  });

}).call(this);
