namespace projekatFlutter.Models
{
    public interface IEntity<Tkey>
    {   // using interface i ensure that every class that implements it will have ID property.
         Tkey Id { get; set; }//id is required becouse its used for delete,update...
    }
}
