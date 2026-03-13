package com.swiftride.model;

import java.sql.Time;
import java.sql.Timestamp;

public class Bus {
    private int busId;
    private String busName;
    private String busType;
    private String busNumber;
    private int totalSeats;
    private int routeId;
    private Time departureTime;
    private Time arrivalTime;
    private double ticketPrice;
    private String amenities;
    private double rating;
    private int totalRatings;
    private String operatorName;
    private boolean isActive;
    private Timestamp createdAt;

    // Transient fields for display
    private String origin;
    private String destination;
    private String estimatedDuration;
    private int availableSeats;

    public Bus() {}

    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }
    public String getBusName() { return busName; }
    public void setBusName(String busName) { this.busName = busName; }
    public String getBusType() { return busType; }
    public void setBusType(String busType) { this.busType = busType; }
    public String getBusTypeDisplay() {
        if (busType == null) return "";
        switch (busType) {
            case "AC_SLEEPER": return "AC Sleeper";
            case "AC_SEATER": return "AC Seater";
            case "NON_AC_SLEEPER": return "Non-AC Sleeper";
            case "NON_AC_SEATER": return "Non-AC Seater";
            default: return busType;
        }
    }
    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }
    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }
    public int getRouteId() { return routeId; }
    public void setRouteId(int routeId) { this.routeId = routeId; }
    public Time getDepartureTime() { return departureTime; }
    public void setDepartureTime(Time departureTime) { this.departureTime = departureTime; }
    public Time getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(Time arrivalTime) { this.arrivalTime = arrivalTime; }
    public double getTicketPrice() { return ticketPrice; }
    public void setTicketPrice(double ticketPrice) { this.ticketPrice = ticketPrice; }
    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    public int getTotalRatings() { return totalRatings; }
    public void setTotalRatings(int totalRatings) { this.totalRatings = totalRatings; }
    public String getOperatorName() { return operatorName; }
    public void setOperatorName(String operatorName) { this.operatorName = operatorName; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }
    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }
    public String getEstimatedDuration() { return estimatedDuration; }
    public void setEstimatedDuration(String estimatedDuration) { this.estimatedDuration = estimatedDuration; }
    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public String getDepartureFormatted() {
        return departureTime != null ? departureTime.toString().substring(0, 5) : "";
    }
    public String getArrivalFormatted() {
        return arrivalTime != null ? arrivalTime.toString().substring(0, 5) : "";
    }
}
