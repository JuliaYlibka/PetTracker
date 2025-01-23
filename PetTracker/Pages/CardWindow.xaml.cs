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
using System.Windows.Shapes;

namespace PetTracker.Pages
{
    /// <summary>
    /// Логика взаимодействия для CardWindow.xaml
    /// </summary>
    public partial class CardWindow : Window
    {
        private PetTracker.Animal currentAnimal =new PetTracker.Animal();

        PetTracker.User user = new PetTracker.User();
        public CardWindow(Animal selectedAnimal, User user)
        {
            InitializeComponent();
            if (user == null)
            {
                MessageBox.Show("Что-то пошло не так! Попробуйте авторизоваться снова.");
                return;
            }
            this.user = user;
            if (user.Role == 1) //admin
                delbor.Visibility = Visibility.Visible;
            if (user.Role == 2) //user
                delbor.Visibility = Visibility.Hidden;
            var allanimal = PetTrackerBDEntities.GetContext().Animal.ToList();
            var allltypes = PetTrackerBDEntities.GetContext().Type.ToList();
            var allmedicine = PetTrackerBDEntities.GetContext().Medicine.ToList();
            var allTasks = PetTrackerBDEntities.GetContext().Task.ToList();
            if (selectedAnimal != null)
            {
                currentAnimal = selectedAnimal;
                allTasks = allTasks.Where(x => x.Animal == selectedAnimal.ID).ToList();
                ListTasks.ItemsSource = allTasks;
            }
            DataContext = selectedAnimal;
            this.user = user;
        }

        private void ListTasks_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {

        }

        private void ChangeAnimal_Click(object sender, RoutedEventArgs e)
        {
            Window window =new NewCardWindow(currentAnimal);
            window.Show();
        }

        private void DeleteBUT_Click(object sender, RoutedEventArgs e)
        {
            var AnimalForRemoving = currentAnimal;

            if (MessageBox.Show($"Вы точно хотите удалить запись о животном?", "Внимание",
                            MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    List<PetTracker.Task> delTasks = PetTrackerBDEntities.GetContext().Task.Where(x => x.Animal==currentAnimal.ID).ToList();
                    PetTrackerBDEntities.GetContext().Task.RemoveRange(delTasks);
                    PetTrackerBDEntities.GetContext().Animal.Remove(currentAnimal);

                    PetTrackerBDEntities.GetContext().SaveChanges();
                    MessageBox.Show("Данные успешно удалены!");
                    Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }

            }
        }
    }
}
