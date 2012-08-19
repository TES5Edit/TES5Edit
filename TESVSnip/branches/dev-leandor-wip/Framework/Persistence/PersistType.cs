namespace TESVSnip.Framework.Persistence
{
    using System;

    /// <summary>
    /// PersistType indicates the available actions for a Persistable.
    /// </summary>
    [Flags]
    public enum PersistType
    {
        /// <summary>
        /// Indicates that this class may not be persisted.
        /// </summary>
        None = 0x0, 

        /// <summary>
        /// Flag to indicate that the field or property has an assignable default.  
        ///   For classes, it indicates that PersistAssist.Initialize may be caused to set default values.
        /// </summary>
        Initializable = 0x1, 

        /// <summary>
        /// InitializeNew indicates that the object should be constructed from its default constructor.
        /// </summary>
        InitializeNew = 0x2 | Initializable, 

        /// <summary>
        /// Indicates that only declared fields or properties should be persisted.
        /// </summary>
        DeclaredOnly = 0x4, 

        /// <summary>
        /// Indicates that public fields or properties on this class should be persisted automatically.
        /// </summary>
        Public = 0x10, 

        /// <summary>
        /// Indicates that non-public fields or properties on this class should be persisted automatically.
        /// </summary>
        NonPublic = 0x20, 

        /// <summary>
        /// Indicates that instance fields or properties should be persisted automatically.
        /// </summary>
        Instance = 0x40, 

        /// <summary>
        /// Indicates that static fields or properties on this class should be persisted automatically.
        /// </summary>
        Static = 0x80, 

        /// <summary>
        /// Indicates that fields on this class should be persisted automatically.
        /// </summary>
        Fields = 0x100, 

        /// <summary>
        /// Indicates that properties on this class should be persisted automatically.
        /// </summary>
        Properties = 0x200, 

        /// <summary>
        /// Default persist type.
        /// </summary>
        ClassDefault = DeclaredOnly, 

        /// <summary>
        /// Default persist type (Public and Private Instance Fields).
        /// </summary>
        Default = Public | NonPublic | Fields | Instance, 
    }
}