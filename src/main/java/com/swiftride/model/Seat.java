package com.swiftride.model;

public class Seat {
    private int seatId;
    private int busId;
    private String seatNumber;
    private String seatType;
    private boolean isBooked;
    private String travelDate;
    private String lockedUntil;
    private int lockedBy;

    public Seat() {}

    public int getSeatId() { return seatId; }
    public void setSeatId(int seatId) { this.seatId = seatId; }
    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }
    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }
    public String getSeatType() { return seatType; }
    public void setSeatType(String seatType) { this.seatType = seatType; }
    public boolean isBooked() { return isBooked; }
    public void setBooked(boolean booked) { isBooked = booked; }
    public String getTravelDate() { return travelDate; }
    public void setTravelDate(String travelDate) { this.travelDate = travelDate; }
    public String getLockedUntil() { return lockedUntil; }
    public void setLockedUntil(String lockedUntil) { this.lockedUntil = lockedUntil; }
    public int getLockedBy() { return lockedBy; }
    public void setLockedBy(int lockedBy) { this.lockedBy = lockedBy; }
}
