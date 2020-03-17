namespace EventAPI.Models.ViewModels.Categories
{
    public class SubCategoriesViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int ParentCategoryId { get; set; }
        //public ICollection<EventInputModel> Events { get; set; }

    }
}
