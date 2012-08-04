


namespace GDF
{
    using System;

    public partial class GDFBuilder
    {
        #region Nested type: UnWrapped

        // ----------------------------------------------------------------------------------------
        //    _                ___        _..-._   Date: 12/11/08    23:28
        //    \`.|\..----...-'`   `-._.-'' _.-..'     
        //    /  ' `         ,       __.-'' 
        //    )/` _/     \   `-_,   /     Solution: RTFLib
        //    `-'" `"\_  ,_.-;_.-\_ ',    Project : RTFLib                                 
        //        _.-'_./   {_.'   ; /    Author  : Anton
        //       {_.-``-'         {_/     Assembly: 1.0.0.0
        //                                Copyright © 2005-2008, Rogue Trader/MWM
        //        Project Item Name:      GDFBuilder.UnWrapped.cs - Code
        //        Purpose:                Persists Formatting Changes on an GDFBuilder
        // ----------------------------------------------------------------------------------------
        /// <summary>
        ///  Persists Formatting Changes on an GDFBuilder
        /// </summary>
        private class UnWrapped : IDisposable
        {
            #region Fields

            private readonly GDFBuilder _builder;

            #endregion

            #region Constructor

            public UnWrapped(GDFBuilder builder)
            {
                this._builder = builder;
                this._builder._unwrapped = true;
            }

            #endregion

            #region IDisposable Members

            public void Dispose()
            {
                this._builder._unwrapped = false;
                this._builder.Reset();
            }

            #endregion
        }

        #endregion
    }
}