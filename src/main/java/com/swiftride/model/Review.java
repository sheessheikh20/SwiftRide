package com.swiftride.model;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int userId;
    private int busId;
    private int bookingId;
    private int rating;
    private String reviewText;
    private Timestamp createdAt;
    private boolean isApproved;

    // Transient display fields
    private String userName;
    private String busName;

    public Review() {}

    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public boolean isApproved() { return isApproved; }
    public void setApproved(boolean approved) { isApproved = approved; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getBusName() { return busName; }
    public void setBusName(String busName) { this.busName = busName; }
}
