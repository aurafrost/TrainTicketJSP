package trainTicket;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Ticket{
	private int counter=100;
	private String pnr;
	private Date travelDate;
	private Train train;
	private TreeMap<Passenger,Double> passengers=new TreeMap<Passenger,Double>(new Comparator<Passenger>() {
		@Override
		public int compare(Passenger p,Passenger p2) {
			// TODO Auto-generated method stub
			if(p.getName().compareTo(p2.getName())>0)
				return 1;
			else if(p.getName().compareTo(p2.getName())<0)
				return -1;
			else
				return 0;
		}
	}
);

	@SuppressWarnings("deprecation")
	public Ticket(Date date,Train train){
		//DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		Date curr = Calendar.getInstance().getTime();
		//check year
		if(date.getYear()<curr.getYear()) {
			throw new IllegalArgumentException("Travel date should be after current date.");
		}
		//check month if same year
		if(date.getYear()==curr.getYear()&&date.getMonth()<curr.getMonth()) {
			throw new IllegalArgumentException("Travel date should be after current date.");
		}
		if(date.getYear()==curr.getYear()&&date.getMonth()==curr.getMonth()&&date.getDate()<=curr.getDate()){
			throw new IllegalArgumentException("Travel date should be after current date.");
		}
		this.travelDate=date;
		this.train=train;
	}
	
	//post: returns a concatenated string
	private String generatePNR() {
		String s1=train.getSource().substring(0, 1);
		String s2=train.getDestination().substring(0, 1);
		String s3=new SimpleDateFormat("yyyyMMdd").format(travelDate);
		String s4=Integer.toString(getCounter());
		setCounter(getCounter()+1);
		return (s1+s2+"_"+s3+"_"+s4);
	}
	//pre: age is a non-negative
	//post: return fare as a double based on age and gender
	private double calcPassengerFare(Passenger p) {
		int age=p.getAge();
		if(age<=12) {
			return (train.getTicketPrice()*0.5); //50% discount
		}
		else if(age>=60) {
			return (train.getTicketPrice()*0.6); //40% discount
		}
		else if(p.getGender()=='F'||p.getGender()=='f') {
			return (train.getTicketPrice()*0.75); //25% off basically
		}
		else {
			return train.getTicketPrice(); //normal price
		}
	}
	//adds passengers to treemap passengers. calls calcPassengerFare for value.
	public void addPassenger(String name,int age,char gender) {
		Passenger p=new Passenger(name,age,gender);
		Double d=calcPassengerFare(p);
		passengers.put(p, d);
	}
	//uses values in TreeMap passengers to find total price
	private double calculateTotalTicketPrice() {
		if(passengers.isEmpty())
			return 0;
		else {
			double sum=0;
			Object[]o=(passengers.values().toArray());
			for(int i=0;i<o.length;i++) {
				sum+=(double)o[i];
			}
			return sum;
		}
	}
	//create the stringbuilder to be passed to the file
	private StringBuilder generateTicket() {
		String pnr=generatePNR();
		setPnr(pnr);
		String s1="PNR			: "+pnr+"\n";
		String s2="Train no	: "+train.getTrainNo()+"\n";
		String s3="Train Name	: "+train.getTrainName()+"\n";
		String s4="From		: "+train.getSource()+"\n";
		String s5="To			: "+train.getDestination()+"\n";
		String date=new SimpleDateFormat("dd/MM/yyyy").format(travelDate);
		String s6="Travel Date	: "+date+"\n\n";
		String s7="Passengers: \n";
		String s8="Name		Age	 Gender	 Fare\n";
		String s9="";
		//get keys from treeset using iterator
		Set s=passengers.keySet();
		Iterator<Passenger>i=s.iterator();
		while(i.hasNext()) {
			//search treemap
			Passenger p=(Passenger)i.next();
			s9+=p.getName()+"		"+p.getAge()+"	   "+
			p.getGender()+"	"+passengers.get(p)+"\n";
		}
		String s10="Total Price: "+calculateTotalTicketPrice();
		StringBuilder sb=new StringBuilder(s1+s2+s3+s4+s5+s6+s7+s8+s9+s10);	
		return sb;
	}
	public void writeTicket() {
		//to-do
		File fold=new File("C:/tickets");
		if(!fold.exists()) {
			fold.mkdir();
		}
		StringBuilder sb=generateTicket();
		String dest="C:/tickets/"+getPnr()+".txt";
		File f=new File(dest);
		if(!f.exists()) {
			try {
				f.createNewFile();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(f,true);
			BufferedOutputStream bos=new BufferedOutputStream(fos);
			String s=sb.toString();
			byte[]b=s.getBytes();
			bos.write(b);
			bos.flush();
			bos.close();
			fos.close();
			//to-finish
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	//getters and setters
	public int getCounter() {
		return counter;
	}
	public void setCounter(int counter) {
		this.counter = counter;
	}
	public String getPnr() {
		return pnr;
	}
	public void setPnr(String pnr) {
		this.pnr = pnr;
	}
	public Date getTravelDate() {
		return travelDate;
	}
	public void setTravelDate(Date travelDate) {
		this.travelDate = travelDate;
	}
	public Train getTrain() {
		return train;
	}
	public void setTrain(Train train) {
		this.train = train;
	}
	public TreeMap<Passenger, Double> getPassengers() {
		return passengers;
	}
	public void setPassengers(TreeMap<Passenger, Double> passengers) {
		this.passengers = passengers;
	}

	
}
