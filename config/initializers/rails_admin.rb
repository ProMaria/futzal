RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index   do
        except ['Doc']
    end                       # mandatory
    new do
        except ['Doc']
    end
    export
    bulk_delete do
       # except ['Team']
    end
    show
    edit
    delete do
        #except ['Team']
    end
        
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  config.model Team do
       list do
        field :name
        field :image
        field :league
       end
        create do
            field :name
        field :image
        field :league
        end

        edit do
            field :name
        field :image
        field :league
        end        
        
    
  end

  config.model League do
        field :name
    
  end
  
  config.model TableResult do
        field :league
        field :team
        field :place
    
  end
 
 
  config.model User do
      create do
        field :email
        field :active_admin
        field :password
        field :password_confirmation
      end
      
      list do
        field :email
        field :active_admin
      end
      
  end      

  config.model Tour do
        field :name
    
  end
  config.model Amplua do
        field :name
    
  end
  config.model Contact do
        field :body
    
  end
  config.model Item do
        field :title
        field :body_preview
        field :body
        field :image
    
  end  # other
  config.model Schedule do
        field :tour
        field :timestamp
        field :home_team
        field :guest_team
        field :result
        field :summary
    
  end
  config.model GoalLeader do
        list do
        field :team
        field :fio
        field :goal
        field :league do
         formatted_value{ bindings[:object].team.league.name }
        end
        end
  end  #  #
end
