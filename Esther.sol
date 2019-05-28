pragma solidity ^0.4.19;

import "./StringUtils.sol";

contract Esther {
    using StringUtils for string;
    /*
        TODO: Add require(bool, "message")
    */

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

    mapping(address => string) userNames;

    Topic[] private topics;

    //constructor() public { }

    function setUserName(string userName) public {
        userNames[msg.sender] = userName;
    }

    function addTopic(string subject, string message) public {
        require(subject.isEmpty());
        require(message.isEmpty());

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
        require(topicId == (countTopics() - 1));
        require(message.isEmpty());

        Topic storage topic = topics[topicId];
        topic.posts[topic.numberOfPosts] = Post({
            id: topic.numberOfPosts,
            message: message,
            userAddress: msg.sender,
            timestamp: now
            });
        topic.numberOfPosts++;
    }

    function getTopic(uint256 topicId) public view returns (uint256 id, string subject, string message, address userAddress, string userName, uint256 timestamp) {
        Topic storage topic = topics[topicId];
        return (topic.id, topic.subject, topic.message, topic.userAddress, getUsername(topic.userAddress).toNaIfEmpty(), topic.timestamp);
    }

    function getPostAtTopic(uint256 topicId, uint256 postId) public view returns(uint256 id, string message, address userAddress, string userName, uint256 timestamp) {
        Post storage post = topics[topicId].posts[postId];
        return (post.id, post.message, post.userAddress, getUsername(post.userAddress).toNaIfEmpty(), post.timestamp);
    }

    function getUsername(address userAddress) public view returns (string) {
        return userNames[userAddress];
    }

    function countPostsAtTopic(uint256 topicId) public view returns (uint256) {
        return topics[topicId].numberOfPosts;
    }

    function countTopics() public view returns (uint256) {
        return topics.length;
    }
}
