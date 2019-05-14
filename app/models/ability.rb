
    class Ability
      include CanCan::Ability

      def initialize(usuario)
        if usuario.present?
          if usuario.level >= '5'  
            can :manage, :all
          else
            cannot :manage, :all        
          end
        else
            cannot :manage, :all
        end
      end
    end
