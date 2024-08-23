import Bool "mo:base/Bool";
import Nat "mo:base/Nat";

import Array "mo:base/Array";
import Time "mo:base/Time";
import Text "mo:base/Text";
import List "mo:base/List";
import Debug "mo:base/Debug";

actor {
  // Define the Post type
  public type Post = {
    id: Nat;
    title: Text;
    body: Text;
    author: Text;
    timestamp: Time.Time;
  };

  // Stable variable to store posts
  stable var posts : [Post] = [];
  stable var nextId : Nat = 0;

  // Query to get all posts
  public query func getPosts() : async [Post] {
    Array.reverse(posts)
  };

  // Update call to create a new post
  public func createPost(title: Text, body: Text, author: Text) : async () {
    let post : Post = {
      id = nextId;
      title = title;
      body = body;
      author = author;
      timestamp = Time.now();
    };
    posts := Array.append([post], posts);
    nextId += 1;
    Debug.print("New post created: " # title);
  };

  // Helper function to get a specific post by ID
  public query func getPost(id: Nat) : async ?Post {
    Array.find(posts, func (p: Post) : Bool { p.id == id })
  };
}
