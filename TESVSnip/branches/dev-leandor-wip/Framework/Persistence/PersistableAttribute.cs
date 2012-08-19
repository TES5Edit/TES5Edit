namespace TESVSnip.Framework.Persistence
{
    using System;

    /// <summary>
    /// The Persistable attribute is similar to Serializable as it tags classes, fields or properties 
    ///   as persistable.  It is used in conjunction with .
    /// </summary>
    /// <remarks>
    /// This class is used with PersistAssist for semi-automated persistance.  
    ///   Its intended to minimize boiler plate serialization.
    /// </remarks>
    [AttributeUsage(AttributeTargets.Struct | AttributeTargets.Class | AttributeTargets.Field | AttributeTargets.Property)]
    public sealed class PersistableAttribute : Attribute
    {
        private PersistContextStates _context = PersistContextStates.ExcludeNone;

        private PersistType _type = PersistType.Default;

        /// <summary>
        /// Gets or sets the Context states when this values is persisted.
        /// </summary>
        /// <value>
        /// The context.
        /// </value>
        public PersistContextStates Context
        {
            get
            {
                return this._context;
            }

            set
            {
                this._context = value;
            }
        }

        /// <summary>
        /// Gets or sets the default value of a field or property.
        /// </summary>
        /// <remarks>
        /// If deserialization fails due to version this value will be used if available or if Intializable is set.
        ///   If Intializable is set then the default value can be used to intialize a value even if null.
        /// </remarks>
        /// <value>
        /// The default.
        /// </value>
        public object Default { get; set; }

        /// <summary>
        /// Gets or sets the intended persistance defaults.
        /// </summary>
        /// <value>
        /// The flags.
        /// </value>
        public PersistType Flags
        {
            get
            {
                return this._type;
            }

            set
            {
                this._type = value;
            }
        }

        /// <summary>
        /// Gets or sets the version of a class, field or property.
        /// </summary>
        /// <remarks>
        /// If a higher version is encountered then the current version then value is not set.
        ///   If the value has a default that is used to initialize the field or property if the value cannot be set
        ///   (this is independent of the Initializable flag usage).
        /// </remarks>
        /// <value>
        /// The version.
        /// </value>
        public int Version { get; set; }
    }
}