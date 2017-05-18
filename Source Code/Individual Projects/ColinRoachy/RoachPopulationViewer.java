package roachy;

import java.awt.event.*;
import javax.swing.*;

/**
 * This program displays the growth of a roach population.
 */
public class RoachPopulationViewer
{
	private static final int FRAME_WIDTH = 800;
	private static final int FRAME_HEIGHT = 200;

	public static void main(String[] args)
	{
		JFrame frame = new JFrame();

		JButton button = new JButton("Double roach population!");
		JButton button2 = new JButton("Half roach population!");
		JButton button3 = new JButton("Square roach population!");
		JButton button4 = new JButton("Root roach population!");

		final RoachPopulation roachPopulation = new RoachPopulation(2);

		// The label for displaying the results
		final JLabel label = new JLabel("population: " + roachPopulation.getPopulation());

		// The panel that holds the user interface components
		JPanel panel = new JPanel();
		panel.add(button);
		panel.add(label);
		frame.add(panel);
		panel.add(button2);
		panel.add(label);
		frame.add(panel);
		panel.add(button3);
		panel.add(label);
		frame.add(panel);
		panel.add(button4);
		panel.add(label);
		frame.add(panel);

		class PopulationDoublerListener implements ActionListener
		{
			public void actionPerformed(ActionEvent event)
			{
				roachPopulation.doublePopulation();
				label.setText("Population: " + roachPopulation.getPopulation());
			}
		}
		class PopulationHalverListener implements ActionListener
		{
			public void actionPerformed(ActionEvent event)
			{
				roachPopulation.halfPopulation();
				label.setText("Population: " + roachPopulation.getPopulation());
			}
		}
		class PopulationSquarerListener implements ActionListener
		{
			public void actionPerformed(ActionEvent event)
			{
				roachPopulation.squarePopulation();
				label.setText("Population: " + roachPopulation.getPopulation());
			}
		}
		class PopulationRooterListener implements ActionListener
		{
			public void actionPerformed(ActionEvent event)
			{
				roachPopulation.rootPopulation();
				label.setText("Population: " + roachPopulation.getPopulation());
			}
		}
		class TimeListener implements ActionListener
		{
			public void actionPerformed(ActionEvent event)
			{
				roachPopulation.breedPopulation();
				label.setText("Population: " + roachPopulation.getPopulation());
			}
		}
		ActionListener listener = new PopulationDoublerListener();
		button.addActionListener(listener);
		ActionListener listener2 = new PopulationHalverListener();
		button2.addActionListener(listener2);
		ActionListener listener3 = new PopulationSquarerListener();
		button3.addActionListener(listener3);
		ActionListener listener4 = new PopulationRooterListener();
		button4.addActionListener(listener4);
		ActionListener listener5 = new TimeListener();
		Timer breed = new Timer(500, listener5);
		breed.start();
		frame.setSize(FRAME_WIDTH, FRAME_HEIGHT);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}
}
