using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace PetTracker.Pages
{
    /// <summary>
    /// Логика взаимодействия для AnimalsPage.xaml
    /// </summary>
    public partial class AnimalsPage : Page
    {
        PetTracker.User user = new PetTracker.User();
        public AnimalsPage(PetTracker.User user)
        {
            InitializeComponent();
            if(user == null)
            {
                MessageBox.Show("Что-то пошло не так! Попробуйте авторизоваться снова.");
                return;
            }
            this.user = user;
            if (user.Role == 1) //admin
                But_Add.Visibility = Visibility.Visible;
            if (user.Role == 2) //user
                But_Add.Visibility = Visibility.Hidden;
            var currentAnimals = PetTrackerBDEntities.GetContext().User.ToList();
            ListAnimals.ItemsSource = currentAnimals;
            CB_Find.SelectedIndex = 0;
            Update();
        }
        private void Update()
        {
            //загружаем всех пользователей в список
            var currentAnimals = PetTrackerBDEntities.GetContext().Animal.ToList();

            //осуществляем поиск по Ф.И.О. без учета регистра букв
            currentAnimals = currentAnimals.Where(x => x.Name.ToLower().Contains(TB_Find.Text.ToLower())).ToList();

            //осуществляем сортировку в зависимости от выбора пользователя
            if (CB_Find.SelectedIndex == 0)
                ListAnimals.ItemsSource = currentAnimals.OrderBy(x => x.Name).ToList();
            else ListAnimals.ItemsSource = currentAnimals.OrderByDescending(x => x.Name).ToList();
        }
        private void TB_Find_TextChanged(object sender, TextChangedEventArgs e)
        {
            Update();
        }

        private void CB_Find_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }
        private void But_Clear_Click(object sender, RoutedEventArgs e)
        {
            CB_Find.SelectedIndex = 0;
            TB_Find.Clear();
            Update();
        }


        private void But_Add_Click(object sender, RoutedEventArgs e)
        {
            Window Card = new NewCardWindow(null);
            Card.Show();
        }

        private void ListAnimals_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            try
            {
                if (ListAnimals.SelectedItem != null)
                {
                    var selectedAnimal = ListAnimals.SelectedItem as PetTracker.Animal; // Замените Partner на актуальное имя вашего класса

                    if (selectedAnimal != null)
                    {
                        Window window = new CardWindow(selectedAnimal, user);
                        window.Show();
                    }
                    else
                    {
                        MessageBox.Show("Ошибка: выбранный элемент не является питомцем.");
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка: {ex.Message}");
            }
        }
    }
}
