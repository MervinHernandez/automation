﻿using System;
using System.Collections.Generic;
using System.Linq;

namespace ConsoleApp1
{
    public class Program
    {
        public static void Main(string[] args)
        {
            // Create a delicious data source.
            string[] fruits = { "cherry", "apple", "blueberry" };

            // Query for ascending sort.
            IEnumerable<string> sortAscendingQuery =
                from fruit in fruits
                orderby fruit //"ascending" is default
                select fruit;

            // Query for descending sort.
            IEnumerable<string> sortDescendingQuery =
                from w in fruits
                orderby w descending
                select w;

            // Execute the query.
            Console.WriteLine("Ascending:");
            foreach (string s in sortAscendingQuery)
            {
                Console.WriteLine(s);
            }

            // Execute the query.
            Console.WriteLine(Environment.NewLine + "Descending:");
            foreach (string s in sortDescendingQuery)
            {
                Console.WriteLine(s);
            }

            // Keep the console window open in debug mode.
            Console.WriteLine("Press any key to exit.");
            Console.ReadKey();
        }
    }
}
