import java.util.Scanner;
public class Taxes 
{
	private static Scanner scanner;
	public static void main(String[] args) 
	{
		scanner = new Scanner(System.in);
		boolean dummy = true;
		String input;
		double cash = 0;
		double taxes = 0;
		int[] cashBrackets = {0, 8000, 32000};
		while(dummy == true)
		{
			dummy = false;
			System.out.println("Married? (y/n): ");
			input = scanner.next();
			if(input.equalsIgnoreCase("Y") || input.equalsIgnoreCase("YES"))
			{
				for(int i = 0; i < 3; i++)
				{
					cashBrackets[i] *= 2;
				}
			}
			else if(!(input.equalsIgnoreCase("N") || input.equalsIgnoreCase("NO")))
			{
				dummy = true;
				System.out.println("Input invalid. Please enter Y or N.");
			}
			valid:
			if(!dummy)
			{
				System.out.println("Enter Income: ");
				cash = scanner.nextDouble();
				if(cash < cashBrackets[0])
				{
					System.out.println("Please enter a positive income.");
					dummy = true;
					break valid;
				}
				else if(cash < cashBrackets[1])
				{
					taxes = cash*.1;
				}
				else if(cash < cashBrackets[2])
				{
					taxes = cashBrackets[1]*.1 + (cash - cashBrackets[1])*.15;
				}
				else if(cash < cashBrackets[3])
				{
					taxes = cashBrackets[1]*.1 + cashBrackets[2]*.15 + (cash-cashBrackets[2])*.25;
				}
			}
		}
		System.out.println("Taxes: " + taxes);
		System.out.println("Income after Taxes: " + (cash-taxes));
		scanner.close();
	}
}
