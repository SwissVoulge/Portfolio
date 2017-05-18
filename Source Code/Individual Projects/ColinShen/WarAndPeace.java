import java.util.Random;
import java.util.Scanner;

public class WarAndPeace
{
	private static Scanner scanner = new Scanner(System.in);
	private static Random rand = new Random();
	public static void main(String[] args)
	{
		int[][]population = new int[100][6];
		int[] basePop = {767, 3634, 30, 729, 307, 511};
		String[] continents = { "Africa", "Asia", "Australia", "Europe", "North America", "South America" };
		for(int i = 0; i < 6; i++)
		{
			population[0][i] = basePop[i];
		}
		int year = 0;
		while(population[year][4] > 9 && population[year][4] < 1001)
		{
			year ++;
			boolean valid = false;
			while (valid != true)
			{
				System.out.println(valid);
				System.out.println("Is there peace or war?");
				String input = scanner.nextLine().toLowerCase();
				//String input = "";
				if(input.equals("peace") || input.equals("p"))
				{
					valid = true;
					for(int k = 0; k < 6; k++)
					{
						population[year][k] = (int) (population[year-1][k]*(1.15+(rand.nextFloat()*.2)));
						System.out.println(continents[k]+": "+population[year][k]);
					}
				}
				else if(input.equals("war") || input.equals("w"))
				{
					valid = true;
					for(int k = 0; k < 6; k++)
					{
						population[year][k] = (int) (population[year-1][k]*(.65+(rand.nextFloat()*.2)));
						System.out.println(continents[k]+": "+population[year][k]);
					}
				}
				else
				{
					System.out.println("Please enter \"peace\" or \"war\"");
					valid = false;
				}
			}
		}
		scanner.close();
	}
}
