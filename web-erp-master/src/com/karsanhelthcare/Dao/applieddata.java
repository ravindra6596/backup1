package com.karsanhelthcare.Dao;

public class applieddata {
private String name;
private String amount;
private String updated_at;
private String detail;
private String mailStatus;
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getAmount() {
	return amount;
}
public void setAmount(String amount) {
	this.amount = amount;
}
public String getUpdated_at() {
	return updated_at;
}
public void setUpdated_at(String updated_at) {
	this.updated_at = updated_at;
}
public String getDetail() {
	return detail;
}
public void setDetail(String detail) {
	this.detail = detail;
}
public String getMailStatus() {
	return mailStatus;
}
public void setMailStatus(String mailStatus) {
	this.mailStatus = mailStatus;
}
@Override
public String toString() {
	return "applieddata [name=" + name + ", amount=" + amount + ", updated_at=" + updated_at + ", detail=" + detail
			+ ", mailStatus=" + mailStatus + "]";
}



}
