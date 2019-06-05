pragma solidity ^0.4.19;

import "./Username.sol";

contract Esther is Username {
    event AddPost(uint256 topicId, string message, address userAddress, uint256 timestamp);
    event AddTopic(string subject, string message, address userAddress, uint256 timestamp);

    struct Post {
        uint256 id;
        string message;
        address userAddress;
        uint256 timestamp;
    }

    struct Topic {
        uint256 id;
        string subject;
        string message;
        address userAddress;
        uint256 timestamp;
        uint256 numberOfPosts;
        mapping(uint256 => Post) posts;
    }

    Topic[] private topics;

    //constructor() public { }

    function addTopic(string subject, string message) public {
        require(!subject.isEmpty() && !message.isEmpty());

        uint256 id = topics.length;
        topics.push(Topic({
            id: id,
            subject: subject,
            message: message,
            userAddress: msg.sender,
            timestamp: now,
            numberOfPosts: 0
            })
        );
    }

    function addPostToTopic(uint256 topicId, string message) public {
        require((topicId < countTopics()) && (topicId >= 0) && !message.isEmpty());

        Topic storage topic = topics[topicId];
        topic.posts[topic.numberOfPosts] = Post({
            id: topic.numberOfPosts,
            message: message,
            userAddress: msg.sender,
            timestamp: now
            });
        topic.numberOfPosts++;
    }

    function getTopic(uint256 topicId) public view returns (uint256 id, string subject, string message, address userAddress, string userName, uint256 timestamp, uint256 numberOfPosts) {
        Topic storage topic = topics[topicId];
        return (topic.id, topic.subject, topic.message, topic.userAddress, getUsername(topic.userAddress).toNaIfEmpty(), topic.timestamp, topic.numberOfPosts);
    }

    function getPostAtTopic(uint256 topicId, uint256 postId) public view returns(uint256 id, string message, address userAddress, string userName, uint256 timestamp) {
        Post storage post = topics[topicId].posts[postId];
        return (post.id, post.message, post.userAddress, getUsername(post.userAddress).toNaIfEmpty(), post.timestamp);
    }

    function countPostsAtTopic(uint256 topicId) public view returns (uint256) {
        return topics[topicId].numberOfPosts;
    }

    function countTopics() public view returns (uint256) {
        return topics.length;
    }
}
