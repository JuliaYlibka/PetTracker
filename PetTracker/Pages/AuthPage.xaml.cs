using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
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
    /// Логика взаимодействия для AuthPage.xaml
    /// </summary>
    public partial class AuthPage : Page
    {
        public AuthPage()
        {
            InitializeComponent();
            // Call the asynchronous method for fetching the image.
            GetImage();
        }

        private async void GetImage()
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    string url = "https://random.dog/woof?filter=mp4,webm"; // Correct URL with HTTP
                    var response = await client.GetStringAsync(url);

                    // This would typically return a JSON structure; parsing it depends on the API response format.
                    // Assuming the response is just the URL (adjust as per actual response).
                    // If it returns a JSON object, you would need to deserialize it.

                    // Example of simple string parsing, make sure this matches the actual format returned.
                    var imageUrl = response; // This should just be the URL string.
                    im.Source = new BitmapImage(new Uri("https://random.dog/"+response));
                    // Displaying URL or the image based on type
                    MessageBox.Show($"Dog Image/Video URL: {imageUrl}");
                    
                    // If you want to display the image in an Image control on your UI:
                    // var imageControl = new Image();
                    // imageControl.Source = new BitmapImage(new Uri(imageUrl));
                    // Your Layout (e.g., stack panel) should have the image added to it, if desired.

                }
                catch (Exception ex)
                {
                    MessageBox.Show($"An error occurred: {ex.Message}");
                }
            }
        }


        private void AuthBUT_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(LoginTB.Text) || string.IsNullOrEmpty(PasswordTB.Password))
            {
                MessageBox.Show("Введите логин и пароль!");
                return;
            }

            using (var db = new PetTrackerBDEntities())
            {
                var users = db.User.AsNoTracking().ToList();

                var user = users.FirstOrDefault(u => u.Login == LoginTB.Text && u.Password == PasswordTB.Password);

                if (user == null)
                {
                    MessageBox.Show("Пользователя с такими данными не найден!");
                    return;
                }

                MessageBox.Show("Пользователь успешно найден!");

                NavigationService?.Navigate(new AnimalsPage(user));
                
            }
        }
    }
}
