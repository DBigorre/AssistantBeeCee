class Question < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :link
  before_validation :to_ascii
  before_validation :linked

  include PgSearch::Model
  pg_search_scope :search_by_query,
  against: [ :query ],
  using: {
    tsearch: { prefix: true }
  }

  def to_ascii
    self.query = ActiveSupport::Inflector.transliterate(query).to_s
  end

  def linked
    link0 = Link.where(url: nil).first
    if self.link.nil?
      self.link = link0
      self.linked = false
    else
      self.linked = true
    end
  end

  $tags = [ "Localisation", "Horaires", "Collaborateurs", "Métiers", "Réseaux Sociaux", "Clients", "Site web", "Evenement", "Recrutement", "Contact"]


  # champs lexicaux des tags

LOCALISATION = ["localisation", "emplacement", "gps", "localiser", "lieu", "lieux", "adresse", "position", "situer", "situe", "situez", "implantation", "implanter",
"implantez", "localite", "ville", "pays", "code postal", "genipa", "parking", "alentour", "autour", "coordonnee", "coordonnees", "ducos", "martinique", "antilles", "locaux", "siege social"]

HORAIRES = ["horaire", "horaires","fuseau", "heure", "ouverture", "fermeture", "heure", "heures", "matin", "apres-midi", "apres midi", "soir",
"matinee", "week-end", "week end", "midi", "minute", "minutes", "seconde", "secondes", "creneau"]

COLLABORATEUR = ["collaborateurs","collaborateur", "collaboration", "employes", "employe", "gerant", "directeur", "directeur de clientele", "directrice de clientele",
"assistant", "assistante", "direction", "charge", "chargee", "pole web", "community", "manager", "basile",
"clementine", "gerant" "kelly", "alexandra", "alwin", "salarie", "salaries", "adjoint", "coequipier", "coequipiere", "partenaire"]

METIER = ["social media", "communication", "achat d'espace", "digital", "crea", "print", "online", "offline", "evenementiel", "developpement web", "publicité", "seo", "sem", "référencement", "achat de mots clés", "posts sponsorisés", "gerant", "directeur", "directeur de clientele", "assistant", "assistante", "direction", "chargé", "chargée", "pole web", "community", "manager", "chef de projet", "developpeur", "community manager", "graphiste", "designer", "DA", "photographe"]

RESEAU_SOCIAL = ["internet", "facebook", "instagram", "twitter", "linkedin", "tiktok", "tik tok", "indeed", "reseau social", "reseaux sociaux",
"publications", "publication", "visibilité", "beecee", "reseau social", "communication digitale", "stratégie reseaux sociaux"]

CLIENT = ["client", "clients", "cliente", "clientele", "acheteur", "acheteuse", "acheteurs", "acquereur", "consommateur", "demandeur", "martinique", "guadeloupe", "guyane", "grande distribution", "distillerie", "concessionnaire"]

SITE_WEB = ["site web", "beecee", "internet", "url", "html", "referencement", "google", "toile", "logo", "creation", "visibilite",
"actualite", "boite", "http"]

EVENEMENT = ["evenement", "evenements", "evenementiel", "festival", "soiree", "inauguration", "rencontre bloggeurs"]

RECRUTEMENT = ["recrutez", "recrutement", "emploi", "employe", "employes", "concours", "formation", "personnel", "personnels", "employeur", "stagiaire",
"profession", "metier", "metiers", "fonction", "travail", "job", "place", "places", "experience", "apprentissage", "apprenti",
"apprentis", "professionel", "offre", "embauche", "embaucher", "embauchez", "entretien", "consultant", "recrutez-vous", "recruter", "salaire", "chef de projet", "developpeur", "community manager", "community", "manager", "chef", "projet", "graphiste", "designer", "DA", "photographe"]

CONTACT = ["contact", "contacter", "joindre", "adresse mail", "email", "rencontrer", "telephone", "telephonique", "message", "relation", "rendez-vous", "rendez vous", "courriel", "infos", "informations",
"joignable", "messagerie", "numero", "reclamation", "renseignement", "appeler", "appel", "appelez"]


end
