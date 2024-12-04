using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Linq;

namespace Client
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    string url = $"http://localhost:40125/SyndicationServiceLibrary/Feed1/students/{textBox1.Text}/notes/atom?format=rss";
                    HttpResponseMessage response = await client.GetAsync(url);
                    response.EnsureSuccessStatusCode();
                    string content = await response.Content.ReadAsStringAsync();
                    string formattedContent = FormatXml(content);
                    richTextBox1.Text = formattedContent;
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка: {ex.Message}");
                }
            }
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    string url = $"http://localhost:40125/SyndicationServiceLibrary/Feed1/students/{textBox1.Text}/notes/json?format=atom";
                    HttpResponseMessage response = await client.GetAsync(url);
                    response.EnsureSuccessStatusCode();
                    string content = await response.Content.ReadAsStringAsync();
                    string formattedContent = FormatXml(content);
                    richTextBox1.Text = formattedContent;
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка: {ex.Message}");
                }
            }
        }

        private string FormatXml(string xmlContent)
        {
            try
            {
                XDocument doc = XDocument.Parse(xmlContent);
                using (var stringWriter = new System.IO.StringWriter())
                using (var xmlTextWriter = new XmlTextWriter(stringWriter))
                {
                    xmlTextWriter.Formatting = Formatting.Indented;
                    doc.Save(xmlTextWriter);
                    return stringWriter.ToString();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при форматировании XML: {ex.Message}");
                return xmlContent;
            }
        }
    }
}
