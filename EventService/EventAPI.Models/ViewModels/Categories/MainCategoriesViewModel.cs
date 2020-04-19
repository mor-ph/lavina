namespace EventAPI.Models.ViewModels.Categories
{
    public class MainCategoriesViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int ParentCategoryId { get; set; }
        //public virtual ICollection<EventInputModel> Events { get; set; }
        //public virtual ICollection<SubCategoriesViewModel> SubCategories { get; set; }
    }
}
