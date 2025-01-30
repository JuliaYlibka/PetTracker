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
    /// Логика взаимодействия для NewCardWindow.xaml
    /// </summary>
    public partial class NewCardWindow : Window
    {
        private PetTracker.Animal currentAnimal= new PetTracker.Animal();
        public NewCardWindow(Animal selectedAnimal)
        {
            InitializeComponent();
            GenderCB.ItemsSource = PetTrackerBDEntities.GetContext().Gender.ToList();

            if(selectedAnimal!=null)
            {
                currentAnimal = selectedAnimal;
                GenderCB.SelectedItem = currentAnimal.Gender1 ;
                DateBirth.SelectedDate = currentAnimal.DateBirth ;
                
            }
            DataContext = currentAnimal;


        }

        private void NOBUT_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void OKBUT_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(currentAnimal.Name))
                errors.AppendLine("Укажите кличку животного!");
            currentAnimal.DateBirth = DateBirth.SelectedDate;

            if (string.IsNullOrWhiteSpace(currentAnimal.DateBirth.ToString()))
                errors.AppendLine("Укажите дату рождения животного!");
            if ((GenderCB.SelectedItem == null))
                errors.AppendLine("Выберите пол животного!");
            else
                currentAnimal.Gender =(int) GenderCB.SelectedValue;
            
            if (errors.Length > 0)
            {

                MessageBox.Show(errors.ToString());
                return;
            }

            if (currentAnimal.ID == 0)
                PetTrackerBDEntities.GetContext().Animal.Add(currentAnimal);

            try
            {
                PetTrackerBDEntities.GetContext().SaveChanges();
                MessageBox.Show("Данные успешно сохранены!");
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
    }
}
