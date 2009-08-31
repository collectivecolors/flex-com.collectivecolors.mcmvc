package com.collectivecolors.mcmvc.interfaces
{
  //----------------------------------------------------------------------------
  // Imports
  
  import org.puremvc.as3.interfaces.IFacade;

  //----------------------------------------------------------------------------

  public interface IMultiCommandFacade extends IFacade
  {
    /**
		 * Check if a specific Command is registered for a given Notification 
		 * 
		 * @param noteName the name of the <code>INotification</code> to search the <code>ICommand</code> mapping for
		 * @param commandClassRef class reference to <code>ICommand</code> to search for
		 * @return whether the Command is currently registered for the given <code>notificationName</code>.
		 */
    function hasCommandClass( noteName : String, commandClassRef : Class ) : Boolean;
    
    /**
		 * Remove a previously registered <code>ICommand</code> to <code>INotification</code> mapping.
		 * 
		 * @param noteName the name of the <code>INotification</code> to remove the <code>ICommand</code> mapping for
		 * @param commandClassRef class reference to <code>ICommand</code> to remove
		 */
    function removeCommandClass( noteName : String, commandClassRef : Class ) : void; 
  }
}